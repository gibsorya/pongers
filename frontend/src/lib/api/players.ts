import API from "./api";
import { auth0 } from "../services/auth0";

const { getAccessToken } = auth0;

export const getPlayers = async (): Promise<any> => {
  try {
    const response = await API.get("/players");
    return response.data;
  } catch (err) {
    throw err;
  }
}

export const deletePlayer = async (id: number): Promise<any> => {
  try {
    const token = await getAccessToken();
    const response = await API.delete(`/players/${id}`, null, { headers: { 'authorization': `Bearer ${token}` } });
    return response.data;
  } catch (err) {
    throw err;
  }
}

export const createPlayer = async (user: IUser): Promise<any> => {
  try {
    const token = await getAccessToken();
    const response = await API.post("/players", { player: user }, { headers: { 'authorization': `Bearer ${token}` } });
    return response.data;
  } catch (err) {
    throw err;
  }
}