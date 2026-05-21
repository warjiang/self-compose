# GitLab Docker Compose 安装

基于 GitLab 官方文档的 Docker Compose 安装方式，按本仓库目录规范提供独立子目录。

## 目录内容

- `docker-compose.yml`: GitLab CE 单容器编排文件（固定稳定版 tag，可通过变量调整）。
- `.env.example`: 默认变量模板（高位端口 + 占位域名）。

## 前置条件

- 已安装 Docker 与 Docker Compose。
- 机器具备可用磁盘空间（GitLab 数据增长较快，建议预留较大空间）。
- 你需要一个可访问的域名或 IP（不要直接使用 `localhost` 作为最终配置）。

## 快速开始

1. 进入目录：
   ```bash
   cd gitlab
   ```
2. 创建环境变量文件：
   ```bash
   cp .env.example .env
   ```
3. 编辑 `.env`，至少修改以下配置：
   - `GITLAB_HOSTNAME`
   - `GITLAB_EXTERNAL_URL`
   - `GITLAB_HOME`（建议使用绝对路径）
4. 启动服务：
   ```bash
   docker compose up -d
   ```
5. 查看初始化日志：
   ```bash
   docker compose logs -f gitlab
   ```
6. 获取 root 初始密码：
   ```bash
   docker compose exec gitlab grep 'Password:' /etc/gitlab/initial_root_password
   ```
7. 浏览器访问 `GITLAB_EXTERNAL_URL`，用户名 `root`，使用上一步密码登录。

## 端口说明（默认）

- HTTP: `8929`
- HTTPS: `2443`
- SSH: `2424`

默认使用高位端口，避免与宿主机 `80/443/22` 冲突。若修改端口，请保持 `.env` 中以下变量一致：
- `GITLAB_EXTERNAL_URL`
- `GITLAB_HTTP_PORT`
- `GITLAB_SSH_PORT`

## 内网 IP 部署示例

如果没有域名，使用内网 `IP:port` 可以正常部署。示例：

```env
GITLAB_HOSTNAME=192.168.1.10
GITLAB_EXTERNAL_URL=http://192.168.1.10:8929
GITLAB_HTTP_PORT=8929
GITLAB_HTTPS_PORT=2443
GITLAB_SSH_PORT=2424
```

说明：
- `GITLAB_EXTERNAL_URL` 必须和你实际访问地址完全一致（包括端口）。
- 如果使用 SSH clone，地址会使用 `GITLAB_SSH_PORT`（默认 `2424`）。

## 常用命令

```bash
# 查看状态
docker compose ps

# 查看日志
docker compose logs -f gitlab

# 重启
docker compose restart gitlab

# 停止并删除容器（保留数据）
docker compose down
```

## 注意事项

- `initial_root_password` 文件会在首次重启后约 24 小时内被清理，请尽快保存管理员密码。
- 生产环境建议继续完善：SMTP、备份策略、HTTPS 证书、监控告警与版本升级流程。
