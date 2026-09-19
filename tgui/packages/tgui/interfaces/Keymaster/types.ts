import { CSSProperties } from "react";

export type SanctuaryData = {
	name: string;
  id: string;
  description: string;
  subtitle: string;
  width: number;
  height: number;
  floors: number;
  price: number;
};

export type Data = {
  can_read: boolean;
  available_sanctuaries_data: SanctuaryData[];
  stored_money: number;
  selected_sanctuary_id: string;
}

export const subTabBarStyle: CSSProperties = {
  display: 'flex',
  flexWrap: 'wrap',
  gap: '4px',
  justifyContent: 'left',
  margin: '6px 0',
};
