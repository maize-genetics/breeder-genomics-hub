c = get_config()  #noqa

c.JupyterLabTemplates.allowed_extensions = ["*.ipynb"]
c.JupyterLabTemplates.template_dirs = ["/home/jovyan/templates"]
c.JupyterLabTemplates.include_default = False
c.JupyterLabTemplates.include_core_paths = False