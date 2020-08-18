import React, { useState, useEffect } from 'react';
import { Tabs } from 'antd';
import Form from './Form';
import axios from 'axios';
import { BASE_URL } from '../../main/consts';
import List from './List';

const { TabPane } = Tabs;

export default () => {
  const [formValues, setFormValues] = useState({
    "contract[title]": 'Teste'
  })

  return (
    <>
      <div className="card-container" style={{ marginTop: 20, marginBottom: 25 }}>
        <Tabs type="card">
          <TabPane tab="List contracts" key="1">
            <div className="site-layout-content">
              <List />
            </div>
          </TabPane>
          <TabPane tab="Create contract" key="2">
            <div className="site-layout-content">
              <Form values={formValues} />
            </div>
          </TabPane>
        </Tabs>
      </div>
    </>
  )
};
