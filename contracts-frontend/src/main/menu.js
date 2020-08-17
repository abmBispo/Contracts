import React, { useState } from 'react';
import { Menu } from 'antd';

export default () => {
  const [selectedWindows, setWindow] = useState(['1']);

  return (
    <Menu theme="dark" mode="horizontal" defaultSelectedKeys={selectedWindows}>
      <Menu.Item key="1" onClick={() => setWindow(['1'])}>
        <a href="/#/">Contracts</a>
      </Menu.Item>
      <Menu.Item key="2" onClick={() => setWindow(['2'])}>
        <a href="/#/parties">Parties</a>
      </Menu.Item>
    </Menu>
  )
};
