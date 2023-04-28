import { createAuth0Client, Auth0Client } from '@auth0/auth0-spa-js';
import { get, writable } from "svelte/store";

interface Auth0Config {
  domain: string;
  clientId: string;
  redirectUri: string;
  audience?: string;
  onRedirectCallback?: Function;
}

export const useAuth0 = () => {
  const auth0Client = writable<Auth0Client | null>(null);
  const isAuthenticated = writable<boolean>(false);
  const isLoading = writable<boolean>(true);
  const user = writable<any>(null);
  const error = writable<any>(null);

  const initializeAuth0 = async (config: Auth0Config) => {
    const client = await createAuth0Client({
      domain: config.domain,
      clientId: config.clientId,
      authorizationParams: {
        redirect_uri: config.redirectUri,
        audience: config.audience
      }
    });

    auth0Client.set(client);

    if (!config.onRedirectCallback) {
      config.onRedirectCallback = () =>
        window.history.replaceState(
          {},
          document.title,
          window.location.pathname
        );
    }

    try {
      const search = window.location.search;

      if (
        (search.includes("code=") || search.includes("error=")) &&
        search.includes("state=")
      ) {
        const { appState } = await get(auth0Client).handleRedirectCallback();

        config.onRedirectCallback(appState);
      }
    } catch (err) {
      error.set(err);
    } finally {
      isAuthenticated.set(await get(auth0Client).isAuthenticated());
      user.set(await get(auth0Client).getUser());
      isLoading.set(false);
    }
  };

  const login = async (options?: any) => {
    await get(auth0Client).loginWithRedirect();
  };

  const logout = async (options?: any) => {
    get(auth0Client).logout(options);
  };

  const getAccessToken = async (options?: any) => {
    return await get(auth0Client).getTokenSilently(options);
  };

  return {
    initializeAuth0,
    login,
    logout,
    getAccessToken,
    isAuthenticated,
    isLoading,
    user,
    error
  };
};

export const auth0 = useAuth0();
