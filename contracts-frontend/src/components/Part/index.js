import React from 'react';
import { Breadcrumb } from 'antd';

export default () => (
  <>
    <Breadcrumb style={{ margin: '16px 0' }}>
      <Breadcrumb.Item>App</Breadcrumb.Item>
      <Breadcrumb.Item>Parties</Breadcrumb.Item>
    </Breadcrumb>
    <div className="site-layout-content">Parties</div>
  </>
);
