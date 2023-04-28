<script lang="ts">
  import { auth0 } from "../lib/services/auth0";
  
  let { error } = auth0;

  const { isAuthenticated } = auth0;

  console.log('isAuthenticated', isAuthenticated)
</script>

{#if error}
  <p>{error}</p>
{:else}
  <div class="page-layout__content" />
{/if}