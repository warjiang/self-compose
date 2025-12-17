#!/bin/bash
# opensearch/init/install-ik.sh

# 离线安装 IK 分词器
echo "Installing IK Analysis plugin from local file..."
/usr/share/opensearch/bin/opensearch-plugin install --batch file:///usr/share/opensearch/plugins-local/opensearch-analysis-ik-3.2.0.0.zip

# 注意：不要在这里启动 OpenSearch！
# 此脚本仅用于初始化，执行完毕后主进程会继续启动。