<script lang="ts">
  import axios from "axios";
  import { auth0 } from "../lib/services/auth0";
  import { createPlayer } from "../lib/api/players";
  import { users } from "../lib/stores";

  let name: string = "";
  const { isAuthenticated, user, getAccessToken } = auth0;

  async function handleSubmit(event: Event) {
    event.preventDefault();
    const user: IUser = { name, stats: null };

    await createPlayer(user);

    name = "";
  }
</script>

<!-- Path: frontend/src/components/PlayerForm.svelte -->
<form on:submit|preventDefault={handleSubmit} id="newPlayerForm">
  <input type="text" bind:value={name} />
  <button type="submit">Add Player</button>
</form>
