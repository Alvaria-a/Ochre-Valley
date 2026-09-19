import {
  cardStyle,
  fieldLabelStyle,
  fieldRowStyle,
  fieldValueStyle,
  INK_FAINT,
  INK_SOFT,
  pageStyle,
  PARCHMENT,
  SEAL_RED,
  sectionHeaderStyle,
  subtitleStyle,
  titleStyle,
} from '../common/parchment';
import { useState } from 'react';
import { Button, Divider, Input, Section, Stack, Tabs, Tooltip } from 'tgui-core/components';
import { Window } from 'tgui/layouts';
import { SanctuaryData, Data } from './types';
import { useBackend } from 'tgui/backend';

export const SanctuaryInfoAndBuy = (props: {
  can_read: boolean;
  sortedSanctuaries: SanctuaryData[];
  stored_money: number;
  selected_sanctuary_id: string;
  onSelectSanctuary: (sanctuary_id: string) => void;
  onBuySanctuary: () => void;
}) => {
  return (
    <Stack fill>
      <Stack vertical fill zebra>
        <Stack.Item>
          <div style={cardStyle}>
            LONG-WINDED AHH DESCRIPTION FOR HOME HERE
          </div>
        </Stack.Item>
        <Stack.Item>
          <Button>
            BUY THIS HOME SIRE
          </Button>
        </Stack.Item>
      </Stack>
    </Stack>
  )
}
