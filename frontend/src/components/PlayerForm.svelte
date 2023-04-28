<script lang="ts">
  import axios from "axios";
  import { auth0 } from "../lib/services/auth0";
  import { users } from "../lib/stores";

  let name: string = "";
  const { isAuthenticated, user, getAccessToken } = auth0;

  async function handleSubmit(event: Event) {
    event.preventDefault();
    const user: IUser = { name, stats: null };
    await getAccessToken().then((token) => {
      console.log(token.expires_in)
      axios
          .post(
            "/api/players",
            { player: user },
            {
              headers: {
                authorization: `Bearer ${token}`,
              },
            }
          )
          .then((response) => {
            users.update((users) => [...users, user]);
          })
          .catch((error) => {
            console.error(error);
          });
    });

    name = "";
  }
</script>

<!-- Path: frontend/src/components/PlayerForm.svelte -->
<form on:submit|preventDefault={handleSubmit} id="newPlayerForm">
  <input type="text" bind:value={name} />
  <button type="submit">Add Player</button>
</form>

<ul>
  {#each $users as user}
    <li>{user.name}</li>
  {/each}
</ul>
