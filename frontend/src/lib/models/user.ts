interface IUser {
  id?: number;
  name: string;
  stats: IStats;
}

interface IStats {
  wins: number;
  losses: number;
  skunks: number;
  games: number;
  accuracy: number;
}