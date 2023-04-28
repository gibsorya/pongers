<script>
	import { useNavigate, useLocation } from "svelte-navigator";
	import { auth0 } from "../../lib/services/auth0";

  const { user, isAuthenticated, login } = auth0;

	// const navigate = useNavigate();
	const location = useLocation();

	$: if (!$isAuthenticated) {
		// navigate("/login", {
		// 	state: { from: $location.pathname },
		// 	replace: true,
		// });
    login({ appState: { targetUrl: $location.pathname } })
	}
</script>

{#if $user}
	<slot />
{/if}