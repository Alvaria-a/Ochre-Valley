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

export const SanctuaryOptions = (props: {
  can_read: boolean;
  sortedSanctuaries: SanctuaryData[];
  selected_sanctuary_id: string;
}) => {
  const { act, data } = useBackend<Data>();
  const can_read = !!data.can_read;
  const { selected_sanctuary_id } = data;
  return (
    <Stack fill>
      <Stack vertical fill zebra>
        <Stack.Item>
          <Button>
            HOME ONE
          </Button>
        </Stack.Item>
        <Stack.Item>
          <Button>
            HOME TWO
          </Button>
        </Stack.Item>
      </Stack>
    </Stack>
  )
}
