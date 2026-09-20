import {
  badgeStyle,
  cardStyle,
  compactButtonStyle,
  fieldLabelStyle,
  fieldRowStyle,
  fieldValueStyle,
  FONT_BODY,
  FONT_HEAD,
  FONT_SMALL,
  INK,
  INK_FAINT,
  INK_SOFT,
  inkButtonStyle,
  inkInputStyle,
  pageStyle,
  PARCHMENT,
  PARCHMENT_DEEP,
  PARCHMENT_SHADOW,
  SEAL_AMBER,
  SEAL_RED,
  sectionHeaderStyle,
  subtitleStyle,
  tabStyle,
  titleStyle,
} from '../common/parchment';
import { useState } from 'react';
import { Button, Divider, Input, Section, Stack, Tabs, Tooltip } from 'tgui-core/components';
import { Window } from 'tgui/layouts';
import { SanctuaryData, Data } from './types';
import { useBackend } from 'tgui/backend';

export const SanctuaryOptions = (props: {
  can_read: boolean;
  sortedSanctuaries: SanctuaryData[];
  selected_sanctuary: SanctuaryData;
  onSelectSanctuary: (sanctuary_id: string) => void;
}) => {
  const { onSelectSanctuary, can_read, selected_sanctuary, sortedSanctuaries } = props
  function getSanctuaryButton(sanctuary_data: SanctuaryData) {
      let selected = (sanctuary_data.id === selected_sanctuary.id);
      return (
        <Stack.Item>
          <Button
            fluid
            onClick = {() => {onSelectSanctuary(sanctuary_data.id)}}
            style={inkButtonStyle({color: selected ? PARCHMENT_DEEP : PARCHMENT})}
            //style={inkButtonStyle({color: selected ? PARCHMENT_DEEP : PARCHMENT})}
            selected={selected}
            //backgroundColor={selected ? PARCHMENT_DEEP : PARCHMENT}
          >
            <div style={{
              textAlign: 'center',
              color: INK_SOFT,
              fontStyle: 'italic',
              fontSize: FONT_HEAD,
            }}>
              {sanctuary_data.name}
            </div>
            <div style={{
              textAlign: 'center',
              color: INK_FAINT,
              fontStyle: 'italic',
              fontSize: FONT_SMALL,
              marginBottom: '10px',
            }}>
              {sanctuary_data.subtitle}
            </div>
          </Button>
        </Stack.Item>
      );
    }


    function getAllButtons() {
      let ret: import("react").JSX.Element[] = [];
      sortedSanctuaries.forEach(element => {
        ret.push(getSanctuaryButton(element))
      });
      return ret;
    };

  return (
    <Stack vertical fill scrollable >
      {getAllButtons()}
    </Stack>
  )
}
