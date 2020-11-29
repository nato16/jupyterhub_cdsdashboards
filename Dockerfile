FROM jupyterhub/jupyterhub

RUN pip install jupyter notebook cdsdashboards cdsdashboards[user] \
                voila dash streamlit jhsingle-native-proxy \
                oauthenticator
RUN jupyterhub --generate-config
WORKDIR /srv/jupyterhub

ARG client_id
ENV client_id=${client_id}
ARG client_secret
ENV client_secret=${client_secret}
ARG callback_url
ENV callback_url=${callback_url}


RUN echo "c.JupyterHub.spawner_class = 'cdsdashboards.hubextension.spawners.VariableLocalProcessSpawner'" >>jupyterhub_config.py && \
    echo "c.JupyterHub.allow_named_servers = True" >> jupyterhub_config.py && \
    echo "c.CDSDashboardsConfig.builder_class = 'cdsdashboards.builder.processbuilder.ProcessBuilder'" >> jupyterhub_config.py && \
    echo "from cdsdashboards.app import CDS_TEMPLATE_PATHS" >> jupyterhub_config.py && \
    echo "from cdsdashboards.hubextension import cds_extra_handlers" >> jupyterhub_config.py && \
    echo "c.JupyterHub.template_paths = CDS_TEMPLATE_PATHS" >> jupyterhub_config.py && \
    echo "c.JupyterHub.extra_handlers = cds_extra_handlers" >> jupyterhub_config.py && \
    echo "from oauthenticator.github import GitHubOAuthenticator" >>jupyterhub_config.py && \
    echo "c.JupyterHub.authenticator_class = GitHubOAuthenticator" >>jupyterhub_config.py && \
    echo "c.GitHubOAuthenticator.oauth_callback_url = '"${callback_url}"'" >> jupyterhub_config.py && \
    echo "c.GitHubOAuthenticator.client_id = '"${client_id}"'" >>jupyterhub_config.py && \
    echo "c.GitHubOAuthenticator.client_secret = '"${client_secret}"'" >>jupyterhub_config.py

ENTRYPOINT ["jupyterhub","--ip=0.0.0.0"]
