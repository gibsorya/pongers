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

  const handleLogin = async() => {
    await login();
  }

  const handleLogout = async() => {
    await logout();
  }

  onMount(async () => {
    await initializeAuth0({
      domain: import.meta.env.VITE_AUTH0_DOMAIN,
      clientId: import.meta.env.VITE_AUTH0_CLIENT_ID,
      redirectUri: import.meta.env.VITE_AUTH0_CALLBACK_URL,
      audience: import.meta.env.VITE_AUTH0_AUDIENCE || undefined,
    });
  });
</script>

<main class="container mx-auto">
  <div>
    <a href="https://vitejs.dev" target="_blank" rel="noreferrer">
      <img src={viteLogo} class="logo" alt="Vite Logo" />
    </a>
    <a href="https://svelte.dev" target="_blank" rel="noreferrer">
      <img src={svelteLogo} class="logo svelte" alt="Svelte Logo" />
    </a>
  </div>
  <h1>Vite + Svelte</h1>
  {#if $isAuthenticated}
    <button id="logout" on:click|preventDefault={handleLogout}>Click to Logout</button>
  {:else}
    <button id="login" on:click|preventDefault={handleLogin}>Click to Login</button>
  {/if}

  <!-- <div class="card">
    <Counter />
  </div> -->

  <Router>
    <nav>
      <Link to="/">Home</Link>
      <Link to="/about">About</Link>
      <Link to="/users">Users</Link>
    </nav>
    <div>
      <Route path="/">
        <PlayerTable />
      </Route>
      <Route path="/about">
        <About />
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

  <p>
    Check out <a
      href="https://github.com/sveltejs/kit#readme"
      target="_blank"
      rel="noreferrer">SvelteKit</a
    >, the official Svelte app framework powered by Vite!
  </p>

  <p class="read-the-docs">Click on the Vite and Svelte logos to learn more</p>
</main>

<style>
  .logo {
    height: 6em;
    padding: 1.5em;
    will-change: filter;
    transition: filter 300ms;
  }
  .logo:hover {
    filter: drop-shadow(0 0 2em #646cffaa);
  }
  .logo.svelte:hover {
    filter: drop-shadow(0 0 2em #ff3e00aa);
  }
  .read-the-docs {
    color: #888;
  }
</style>
