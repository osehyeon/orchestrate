#!/bin/bash
# Orchestrate - 클론 후 목표 설정 스크립트
#
# 사용법:
#   ./scripts/clone-and-start.sh <project_name> <template>
#
# 예시:
#   ./scripts/clone-and-start.sh my-feature feature
#   ./scripts/clone-and-start.sh auth-proposal proposal

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

if [ -z "$1" ] || [ -z "$2" ]; then
    echo -e "${YELLOW}사용법:${NC} ./scripts/clone-and-start.sh <project_name> <template>"
    echo ""
    echo -e "${YELLOW}예시:${NC}"
    echo "  ./scripts/clone-and-start.sh my-feature feature"
    echo "  ./scripts/clone-and-start.sh auth-proposal proposal"
    echo "  ./scripts/clone-and-start.sh bug-hunt debug"
    exit 1
fi

PROJECT_NAME="$1"
TEMPLATE="$2"
TARGET_DIR="$(pwd)/${PROJECT_NAME}"

# 대상 디렉토리 확인
if [ -d "$TARGET_DIR" ]; then
    echo -e "${RED}오류: '${TARGET_DIR}' 디렉토리가 이미 존재합니다.${NC}"
    exit 1
fi

# 템플릿 확인
TEMPLATE_FILE="$PROJECT_ROOT/templates/${TEMPLATE}.md"
if [ ! -f "$TEMPLATE_FILE" ]; then
    echo -e "${RED}오류: 템플릿 '${TEMPLATE}'을 찾을 수 없습니다.${NC}"
    exit 1
fi

echo -e "${BLUE}╔══════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Orchestrate - Clone & Start        ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════╝${NC}"
echo ""

# 프로젝트 복사
echo -e "${GREEN}[1/3]${NC} 프로젝트 복사 중..."
rsync -a --exclude='.git' --exclude='proposal/' --exclude='.DS_Store' --exclude='output/' "$PROJECT_ROOT/" "$TARGET_DIR/"

# 새 git 초기화
echo -e "${GREEN}[2/3]${NC} Git 초기화..."
cd "$TARGET_DIR"
git init -q
git add -A
git commit -q -m "init: Orchestrate base project (template: ${TEMPLATE})"

# 안내
echo -e "${GREEN}[3/3]${NC} 완료!"
echo ""
echo -e "${GREEN}프로젝트 경로:${NC} ${TARGET_DIR}"
echo -e "${GREEN}사용 템플릿:${NC} ${TEMPLATE}"
echo ""
echo -e "${YELLOW}다음 단계:${NC}"
echo "  1. cd ${TARGET_DIR}"
echo "  2. claude"
echo "  3. 템플릿 프롬프트(templates/${TEMPLATE}.md)의 {{변수}}를 채워서 입력"
echo ""
