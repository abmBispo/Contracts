import React, { useState } from 'react';
import { Tabs, Button } from 'antd';
import Form from './Form';
import List from './List';
import axios from 'axios';
import { BASE_URL } from '../../main/consts';
const { TabPane } = Tabs;

export default () => {
  const [activeTab, setActiveTab] = useState('list');

  const changeTab = (activeKey) => setActiveTab(activeKey);

  const [panes, setPanes] = useState([]);

  const remove = (targetKey) => {
    const newPanes = panes.filter(pane => pane.key !== targetKey);
    setPanes(newPanes);
    setActiveTab('list');
  };

  const addContractTab = (contractId) => {
    const newPanes = [...panes];

    axios.get(`${BASE_URL}/contracts/${contractId}`)
    .then((res) => {
      const { data } = res.data;

      newPanes.push({
        title: data.title,
        content: (
          <div className="site-layout-content">
            <Form removeTab={remove} initialValues={data}/>
          </div>
        ),
        key: data.title
      });
      setPanes(newPanes);
      changeTab(data.title);
    });
  }

  const addForm = () => {
    const shouldAdd = panes.filter((pane) => {
      return pane.key === 'new-contract'
    }).length == 0;

    if (shouldAdd) {
      const newPanes = [...panes];
      newPanes.push({
        title: 'New contract',
        content: (
          <div className="site-layout-content">
            <Form removeTab={remove} />
          </div>
        ),
        key: 'new-contract'
      });
      setPanes(newPanes);
      changeTab('new-contract');
    }
  };

  const onEdit = (targetKey, action) => {
    if (action === 'remove') remove(targetKey);
  };

  return (
    <Tabs
      type="editable-card"
      onChange={changeTab}
      activeKey={activeTab}
      onEdit={onEdit}
      hideAdd={true}
      tabBarExtraContent={<Button type='primary' onClick={addForm}>New contract</Button>}
      style={{ marginTop: 20 }}>

      <TabPane tab="List contracts" key="list" closable={false}>
        <div className="site-layout-content">
          <List activeKey={activeTab} showContract={addContractTab} />
        </div>
      </TabPane>

      {panes.map(pane => (
        <TabPane tab={pane.title} key={pane.key} closable={pane.closable}>
          {pane.content}
        </TabPane>
      ))}

    </Tabs>
  );
}
