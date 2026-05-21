# OpenClaw Docker Compose Profiles 组件对照

## 服务与组件说明

- `openclaw-gateway`: OpenClaw 主服务（网关 + bridge）。
- `openclaw-installer`: 用于进入容器安装工具/插件的辅助容器（默认不常驻运行）。
- `all-in-one-sandbox`: 沙箱执行环境（`8080` 端口）。
- `clash`: Clash 代理组件（`7890/9090` 端口）。

## Profile 对应安装组件

| Profile | 启动组件 |
| --- | --- |
| `core` | `openclaw-gateway` |
| `minimal` | `openclaw-gateway` + `all-in-one-sandbox` |
| `addon` | `all-in-one-sandbox` + `clash` |
| `tools` | `openclaw-installer` |
| `all` | `openclaw-gateway` + `all-in-one-sandbox` + `clash` |

## 常用启动示例

```bash
# 仅启动 OpenClaw 主服务
docker compose --profile core up -d

# 启动最小可用组合（主服务 + 沙箱）
docker compose --profile minimal up -d

# 启动附加组件（沙箱 + Clash）
docker compose --profile addon up -d

# 启动全部运行组件（不含 installer）
docker compose --profile all up -d

# 启动安装器容器（用于手动安装工具/插件）
docker compose --profile tools up -d
```
