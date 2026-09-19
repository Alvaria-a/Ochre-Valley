import {
  cardStyle,
  fieldLabelStyle,
  fieldRowStyle,
  fieldValueStyle,
  INK_FAINT,
  INK_SOFT,
  pageStyle,
  PARCHMENT,
  rulerStyle,
  SEAL_AMBER,
  SEAL_RED,
  sectionHeaderStyle,
  subtitleStyle,
  tabBarStyle,
  titleStyle,
} from '../common/parchment';
import { useState } from 'react';
import { Box, Button, Divider, Input, Section, Stack, Tabs, Tooltip } from 'tgui-core/components';
import { Window } from 'tgui/layouts';
import { SanctuaryData, Data } from './types';
import { useBackend } from 'tgui/backend';
import { SanctuaryOptions } from './SanctuaryOptions';
import { SanctuaryInfoAndBuy } from './SanctuaryInfoAndBuy';

export const starsIf = (text: string, canRead: boolean) =>
  canRead ? text : text.replace(/[A-Za-z0-9]/g, '*');

export const Keymaster = (props: {
}) => {
  const { act, data } = useBackend<Data>();
  const can_read = !!data.can_read;
  const { stored_money, selected_sanctuary_id } = data;
  const sortedSanctuaries = data.available_sanctuaries_data.sort((a, b) => a.name.toLowerCase().localeCompare(b.name.toLowerCase()));
  return (
    <Window width={780} height={620} theme="parchment">
      <Window.Content>
        <div style={pageStyle}>
          <Stack vertical fill>
            <Stack.Item grow>
              <div style={titleStyle}>THE KEYMASTER</div>
              <div style={subtitleStyle}>
                Thy balance:{' '}
                <span style={{ color: SEAL_AMBER, fontWeight: 'bold' }}>
                  {stored_money}m
                </span>
                {' '}
                <Button icon="coins" onClick={() => {act('refund_money')}}>
                  Refund
                </Button>
              </div>
            </Stack.Item>
            <hr style={rulerStyle} />
              <Box style={{
                display: 'flex',
                flexWrap: 'wrap',
                gap: '4px',
                justifyContent: 'left',
                margin: '6px 0',
              }}>
                <SanctuaryOptions
                  can_read={can_read}
                  sortedSanctuaries={sortedSanctuaries}
                  selected_sanctuary_id={selected_sanctuary_id}
                />
              </Box>
            <Box style={{
                display: 'flex',
                flexWrap: 'wrap',
                gap: '4px',
                justifyContent: 'right',
                margin: '6px 0',
              }}>
                <SanctuaryInfoAndBuy
                  can_read={can_read}
                  sortedSanctuaries={sortedSanctuaries}
                  stored_money={stored_money}
                  selected_sanctuary_id={selected_sanctuary_id}
                  onSelectSanctuary= {(sanctuary_id: string) => {act('select_sanctuary', { selected_id: sanctuary_id })}}
                  onBuySanctuary={() => {act('purchase_sanctuary')}}
                />
            </Box>
          </Stack>
        </div>
      </Window.Content>
    </Window>
  );
};
