import React, { useState } from 'react';
import { Menu } from 'antd';

export default () => {
  const [selectedWindow, setWindow] = useState([window.location.hash.split('/')[1]]);

  return (
    <Menu theme="dark" mode="horizontal" defaultSelectedKeys={selectedWindow}>
      <Menu.Item key="contracts" onClick={() => setWindow(['contracts'])}>
        <a href="/#/contracts">Contracts</a>
      </Menu.Item>
      <Menu.Item key="parties" onClick={() => setWindow(['parties'])}>
        <a href="/#/parties">Parties</a>
      </Menu.Item>
    </Menu>
  )
};
