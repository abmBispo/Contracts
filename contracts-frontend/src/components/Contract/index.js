import React, { useState, useEffect } from 'react';
import { Tabs } from 'antd';
import Form from './Form';
import List from './List';

const { TabPane } = Tabs;

export default () => {
  const [activeTab, setActiveTab] = useState('1');

  const changeTab = (activeKey) => {
    setActiveTab(activeKey);
  }

  return (
    <>
      <div className="card-container" style={{ marginTop: 20, marginBottom: 25 }}>
        <Tabs activeKey={activeTab} onChange={changeTab} type="card">
          <TabPane tab="List contracts" key="1">
            <div className="site-layout-content">
              <List activeKey={activeTab}/>
            </div>
          </TabPane>
          <TabPane tab="Create contract" key="2">
            <div className="site-layout-content">
              <Form changeTab={changeTab}/>
            </div>
          </TabPane>
        </Tabs>
      </div>
    </>
  )
};
