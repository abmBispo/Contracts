import React, { useState } from 'react';
import { Layout, Menu } from 'antd';
import { Router, Route, Redirect, hashHistory } from 'react-router';
import './App.css';
import Contract from './components/Contract';
import Part from './components/Part';

const { Header, Content, Footer } = Layout;

export default () => {
  const [selectedWindows, setWindow] = useState(['1']);

  return (
    <Layout className="layout">
      <Header>
        <div className="logo" />
        <Menu theme="dark" mode="horizontal" defaultSelectedKeys={selectedWindows}>
          <Menu.Item key="1" onClick={() => setWindow(['1'])}>
            <a href="/#/">Contracts</a>
          </Menu.Item>
          <Menu.Item key="2" onClick={() => setWindow(['2'])}>
            <a href="/#/parties">Parties</a>
          </Menu.Item>
        </Menu>
      </Header>
      <Content style={{ padding: '0 50px' }}>
        <Router history={hashHistory}>
          <Route path='/' component={Contract} />
          <Route path='/parties' component={Part} />
          <Redirect from='*' to='/' />
        </Router>
      </Content>
      <Footer style={{ textAlign: 'center' }}>Ant Design ©2018 Created by Ant UED</Footer>
    </Layout>
  )
};
