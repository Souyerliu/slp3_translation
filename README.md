# SLP3 中文翻译电子书

本仓库使用 Jupyter Book 2 和 MyST `book-theme` 渲染中文翻译。

在线阅读：<https://souyerliu.github.io/slp3_translation/>

## 安装

建议使用独立虚拟环境：

```powershell
python -m venv .venv-book
.\.venv-book\Scripts\python.exe -m pip install -r requirements-book.txt
```

## 本地预览

Windows 下直接双击仓库根目录的 `start.bat` 即可一键启动。首次运行时，脚本会自动创建 `.venv-book` 虚拟环境并安装依赖。

也可以在 PowerShell 中运行：

```powershell
.\start.bat
```

如果已经手动安装好环境，也可以直接运行：

```powershell
.\.venv-book\Scripts\jupyter.exe book start
```

随后访问 `http://localhost:3000/`。

## 严格构建

```powershell
.\.venv-book\Scripts\jupyter.exe book build --html --strict
```

静态网站生成在 `_build/html/`。

## GitHub Pages 部署

`main` 分支每次推送后，[Pages 工作流](.github/workflows/pages.yml)会自动严格构建并发布站点。也可以在 GitHub 仓库的 **Actions** 页面手动运行。

首次使用时，请在仓库 **Settings → Pages → Build and deployment → Source** 中选择 **GitHub Actions**。发布成功后访问：

<https://souyerliu.github.io/slp3_translation/>

## 内容检查

Windows PowerShell 执行策略可能禁止直接运行仓库脚本。以下命令只为当前子进程放行，不修改系统策略：

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\check_book.ps1
```

## 脚注

正文中的脚注使用 MyST 原生语法。引用会显示为可点击的上标数字，注释集中显示在当前页面底部，并可跳回引用位置：

```markdown
这里是正文中的说明。[^1]

[^1]: 这里是页面底部的脚注内容。
```

同一页面内的脚注编号必须唯一。表示词义编号、数学上下标等语义的 `<sup>` 和 `<sub>` 标签不应改成脚注。

## 内容范围

当前目录只收录第 1、7、8、9、10 章。新增完整章节时，需要同步更新 `toc.yml` 和 `book/progress.md`。
