#!/bin/bash
# Publish AgentGatePay SDKs v1.1.0 to npm and PyPI

set -e

echo "🚀 Publishing AgentGatePay SDKs v1.1.0"
echo ""

# Check if we're in the right directory
if [ ! -f "README.md" ]; then
    echo "❌ Error: Must run from agentgatepay-sdks repository root"
    exit 1
fi

echo "📋 Current status:"
echo "  JavaScript SDK: v$(grep '"version"' javascript/package.json | head -1 | sed 's/.*: "\(.*\)".*/\1/')"
echo "  Python SDK: v$(grep 'version=' python/setup.py | sed 's/.*version="\(.*\)".*/\1/')"
echo ""

read -p "Do you want to publish via GitHub Actions (automated)? [Y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
    echo "✅ Publishing via GitHub Actions..."
    
    # Create and push JavaScript tag
    echo "📦 Tagging JavaScript SDK..."
    git tag -a js-v1.1.0 -m "Release JavaScript SDK v1.1.0" 2>/dev/null || echo "  Tag js-v1.1.0 already exists"
    git push origin js-v1.1.0
    
    # Create and push Python tag
    echo "🐍 Tagging Python SDK..."
    git tag -a py-v1.1.0 -m "Release Python SDK v1.1.0" 2>/dev/null || echo "  Tag py-v1.1.0 already exists"
    git push origin py-v1.1.0
    
    echo ""
    echo "✅ Tags pushed successfully!"
    echo ""
    echo "🔍 Check publishing progress at:"
    echo "   https://github.com/AgentGatePay/agentgatepay-sdks/actions"
    echo ""
    echo "After publishing completes, verify:"
    echo "   npm: https://www.npmjs.com/package/agentgatepay-sdk"
    echo "   PyPI: https://pypi.org/project/agentgatepay-sdk/"
    
else
    echo ""
    echo "Manual publishing instructions:"
    echo ""
    echo "JavaScript SDK:"
    echo "  cd javascript"
    echo "  npm run build"
    echo "  npm login"
    echo "  npm publish --access public"
    echo ""
    echo "Python SDK:"
    echo "  cd python"
    echo "  python setup.py sdist bdist_wheel"
    echo "  twine upload dist/*"
fi
