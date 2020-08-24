import React from 'react';
import { Breadcrumb, Row, Col, Button } from 'antd';
import List from './List';
import { useHistory } from 'react-router-dom';

export default () => {
  let history = useHistory();

  return <>
    <Breadcrumb style={{ margin: '16px 0' }}>
      <Breadcrumb.Item>App</Breadcrumb.Item>
      <Breadcrumb.Item>Parties</Breadcrumb.Item>
    </Breadcrumb>
    <div className="site-layout-content">
      <List />
      <Row>
        <Col span={24} style={{ textAlign: 'right' }}>
          <Button type='primary' onClick={() => history.push('/parties/new')}>
            Create new part
          </Button>
        </Col>
      </Row>
    </div>
  </>
};
