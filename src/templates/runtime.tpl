/* eslint-disable import/no-dynamic-require */
import React from 'react';
import HomeButtonWrapper from './HomeButtonWrapper';

export function rootContainer(container) {
  return React.createElement(
    HomeButtonWrapper,
    null,
    container,
  );
}