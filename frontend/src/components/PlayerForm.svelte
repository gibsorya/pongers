<script lang="ts">
  import axios from 'axios';
  import { users } from '../lib/stores';
    
  let name: string = ''

  function handleSubmit(event: Event) {
    event.preventDefault()
    const user: IUser = { name, stats: null }
    axios.post('/api/players', {"player": user}, {
      headers: {
        "authorization": `Bearer ${import.meta.env.VITE_AUTH0_AUTH_TOKEN}`
      }
    }).then((response) => {
      console.log(response)
      users.update((users) => [...users, user])
    }).catch((error) => {
      console.error(error)
    }
    )
    name = ''
  }
</script>

<!-- Path: frontend/src/components/PlayerForm.svelte -->
<form on:submit|preventDefault={handleSubmit} id='newPlayerForm'>
  <input type="text" bind:value={name} />
  <button type="submit">Add Player</button>
</form>

<ul>
  {#each $users as user}
    <li>{user.name}</li>
  {/each}
</ul>