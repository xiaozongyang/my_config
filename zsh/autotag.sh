#! /bin/bash

# 获取当前分支的最新tag
get_latest_tag() {
    local prefix=$1
    local pattern

    if [[ -n "$prefix" ]]; then
        pattern="${prefix}v[0-9]*"
    else
        pattern="v[0-9]*"
    fi

    # 获取所有tag并按语义化版本排序，支持前缀
    # 使用 # 作为 sed 的分隔符，避免与路径分隔符 / 冲突
    git tag -l "$pattern.[0-9]*.[0-9]*" "$pattern.[0-9]*.[0-9]*-alpha*" \
        | sed "s#^${prefix}v##" \
        | sed 's/-alpha\./~/' \
        | sort -V \
        | sed 's/~/-alpha./' \
        | tail -n1
}

# 创建新的tag版本号
build_next_tag() {
    local current_tag=$1
    local is_main=$2

    # 首次创建tag的情况
    if [[ -z "$current_tag" ]]; then
        if $is_main; then
            echo "0.1.0"
        else
            echo "0.1.0-alpha.1"
        fi
        return
    fi

    # 解析当前版本号
    local major minor patch alpha
    if [[ $current_tag == *-alpha* ]]; then
        # 处理alpha版本
        major=$(echo $current_tag | cut -d. -f1)
        minor=$(echo $current_tag | cut -d. -f2)
        patch=$(echo $current_tag | cut -d. -f3 | cut -d- -f1)
        alpha=$(echo $current_tag | cut -d. -f4)
    else
        # 处理正式版本
        major=$(echo $current_tag | cut -d. -f1)
        minor=$(echo $current_tag | cut -d. -f2)
        patch=$(echo $current_tag | cut -d. -f3)
    fi

    if $is_main; then
        # main/master分支：创建正式版本
        if [[ $current_tag == *-alpha* ]]; then
            # 如果之前是alpha版本，去掉alpha后缀
            echo "$major.$minor.$patch"
        else
            # 正式版本递增patch号
            echo "$major.$minor.$((patch + 1))"
        fi
    else
        # 其他分支：创建alpha版本
        if [[ $current_tag == *-alpha* ]]; then
            # alpha版本递增alpha号
            echo "$major.$minor.$patch-alpha.$((alpha + 1))"
        else
            # 正式版本创建新的alpha版本，patch号加1
            echo "$major.$minor.$((patch + 1))-alpha.1"
        fi
    fi
}

# 显示帮助信息
show_help() {
    echo "用法: $0 [选项]"
    echo "自动创建并推送新的git tag"
    echo
    echo "选项:"
    echo "  -y        自动确认，不需要手动确认"
    echo "  -m MSG    指定tag的message信息"
    echo "  -p PRE    指定tag前缀，例如: custom-prefix/"
    echo "  -h        显示帮助信息"
    echo
    echo "示例:"
    echo "  $0                                 # 创建并推送tag（需要确认）"
    echo "  $0 -y                              # 自动创建并推送tag"
    echo "  $0 -m \"release v1.0.1\"            # 创建带message的tag"
    echo "  $0 -p custom-prefix/               # 创建带前缀的tag"
}

# 默认值
confirm=""
message=""
prefix=""

# 处理参数
while getopts "hym:p:" opt; do
    case $opt in
        h)
            show_help
            exit 0
            ;;
        y)
            confirm="y"
            ;;
        m)
            message="$OPTARG"
            ;;
        p)
            prefix="$OPTARG"
            ;;
        \?)
            echo "无效的选项: -$OPTARG" >&2
            show_help
            exit 1
            ;;
        :)
            echo "选项 -$OPTARG 需要一个参数" >&2
            show_help
            exit 1
            ;;
    esac
done

# 移除已处理的选项
shift $((OPTIND-1))

# 检查是否有多余的参数
if [ $# -gt 0 ]; then
    echo "警告: 忽略额外的参数: $*"
fi

# check if git is clean
if ! git diff-index --quiet HEAD --; then
    echo "git is dirty, please commit your changes first"
    exit 1
fi

# check if in main or master branch
current_branch=$(git branch --show-current)
is_main_or_master=false
if [[ $current_branch == "main" || $current_branch == "master" ]]; then
    is_main_or_master=true
fi

latest_tag=$(get_latest_tag "$prefix")
echo "latest tag: $prefix$latest_tag"
new_num_tag=$(build_next_tag "$latest_tag" "$is_main_or_master")
new_tag="${prefix}v${new_num_tag}"

if [[ "$confirm" != "y" ]]; then
    read -p "Push tag $new_tag to remote? [y/N] " confirm
fi

if [[ $confirm =~ ^[Yy]$ ]]; then
    echo "create and push tag $new_tag to remote"
    if [[ -n "$message" ]]; then
        git tag -a $new_tag -m "$message"
    else
        git tag $new_tag
    fi
    git push origin $new_tag
fi
