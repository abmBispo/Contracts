import React from 'react';
import { Layout } from 'antd';
import './App.css';
import { GithubOutlined } from '@ant-design/icons'
import Routes from './main/routes';
import Menu from './main/menu';
import { HashRouter } from 'react-router-dom';

const { Header, Content, Footer } = Layout;

export default () => (
  <HashRouter>
    <Layout className="layout">
      <Header>
        <Menu />
      </Header>
      <Content style={{ padding: '0 50px' }}>
        <Routes />
      </Content>
      <Footer style={{ textAlign: 'center' }}>
        Developed by <a href="https://github.com.br/abmbispo"><GithubOutlined /> abmbispo</a> with <a href="https://ant.design/">Ant Design</a>.
      </Footer>
    </Layout>
  </HashRouter>
);
