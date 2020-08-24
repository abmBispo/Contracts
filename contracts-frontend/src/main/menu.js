import React, { useState, useEffect } from 'react';
import { Menu } from 'antd';
import { useLocation } from 'react-router-dom';
import { Link } from 'react-router-dom/cjs/react-router-dom.min';

export default () => {
  const location = useLocation();
  const [selectedWindow, setWindow] = useState(location.pathname);

  useEffect(() => setWindow(location.pathname), [location])

  return (
    <Menu theme="dark" mode="horizontal" defaultSelectedKeys={selectedWindow}>
      <Menu.Item key="/contracts" onClick={() => setWindow(['contracts'])}>
        <Link to='/contracts'>Contracts</Link>
      </Menu.Item>
      <Menu.Item key="/parties" onClick={() => setWindow(['parties'])}>
        <Link to='/parties'>Parties</Link>
      </Menu.Item>
    </Menu>
  )
};
