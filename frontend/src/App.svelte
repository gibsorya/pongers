<script>
  import { Router, Route, Link, useLocation } from "svelte-navigator";
  import svelteLogo from "./assets/svelte.svg";
  import viteLogo from "/vite.svg";
  import Counter from "./components/Counter.svelte";
  import About from "./pages/About.svelte";
  import PlayerForm from "./components/PlayerForm.svelte";
  import PlayerTable from "./components/PlayerTable.svelte";
  import { auth0 } from "./lib/services/auth0";
  import { onMount } from "svelte";
  import Callback from "./pages/Callback.svelte";
  import PrivateRoute from "./components/auth/PrivateRoute.svelte";

  let { isLoading, isAuthenticated, login, initializeAuth0, logout } = auth0;

  const onRedirectCallback = (appState) => {
    window.history.replaceState(
      {},
      document.title,
      appState && appState.targetUrl
        ? appState.targetUrl
        : window.location.pathname
    );
  };

  const handleLogin = async () => {
    await login();
  };

  const handleLogout = async () => {
    await logout();
  };

  onMount(async () => {
    await initializeAuth0({
      domain: import.meta.env.VITE_AUTH0_DOMAIN,
      clientId: import.meta.env.VITE_AUTH0_CLIENT_ID,
      redirectUri: import.meta.env.VITE_AUTH0_CALLBACK_URL,
      audience: import.meta.env.VITE_AUTH0_AUDIENCE || undefined,
      onRedirectCallback,
    });
  });
</script>

<main>
  <Router>
    <nav class="nav flex justify-between items-center">
      <div class="flex">
        <Link to="/">Home</Link>
        <Link to="/users">Users</Link>
      </div>
      <div class="mr-4">
        {#if $isAuthenticated}
          <button id="logout" on:click|preventDefault={handleLogout}
            >Logout</button
          >
        {:else}
          <button id="login" on:click|preventDefault={handleLogin}
            >Login</button
          >
        {/if}
      </div>
    </nav>
    <div>
      <Route path="/">
        <PlayerTable />
      </Route>
      <Route path="/users">
        <h1>Users</h1>
        <Link to="/users/new">New User</Link>
      </Route>
      <PrivateRoute path="/users/new">
        <h1>New User</h1>
        <PlayerForm />
      </PrivateRoute>
      <Route path="/callback" component={Callback} />
    </div>
  </Router>
</main>
