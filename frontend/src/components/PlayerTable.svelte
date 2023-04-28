<script lang="ts">
  import { onMount } from "svelte";
  import { getPlayers, deletePlayer } from "../lib/api/players";
  import { auth0 } from "../lib/services/auth0";

  const { isAuthenticated, user } = auth0;

  let Players: IUser[] = [];

  onMount(async () => {
    Players = await getPlayers();
  });

  const handleDelete = async (player: IUser) => {
    await deletePlayer(player.id);
    Players = await getPlayers();
  }
</script>

<div class='players-table'>
  <table>
    <tr>
      <th>Name</th>
      <th>Wins</th>
      <th>Losses</th>
      {#if $isAuthenticated}
        <th>Delete?</th>
      {/if}
    </tr>
    {#each Players as player}
      <tr>
        <td>{player.name}</td>
        <td>{player.stats?.wins}</td>
        <td>{player.stats?.losses}</td>
        {#if $isAuthenticated}
          <td><button on:click|preventDefault={() => { handleDelete(player) }}>Delete</button></td>
        {/if}
      </tr>
    {/each}
  </table>
</div>