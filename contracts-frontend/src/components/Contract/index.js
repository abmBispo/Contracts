import React, { useState } from 'react';
import { Tabs, Button } from 'antd';
import Form from './Form';
import List from './List';
const { TabPane } = Tabs;

export default () => {
  const [activeTab, setActiveTab] = useState('list');
  const [formId, setFormId] = useState(null);

  const changeTab = (activeKey) => setActiveTab(activeKey);

  const [panes, setPanes] = useState([]);

  const remove = (targetKey) => {
    const newPanes = panes.filter(pane => pane.key !== targetKey);
    setPanes(newPanes);
    setActiveTab('list');
  };

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
            <Form removeTab={remove} formId={formId} />
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
          <List activeKey={activeTab} />
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

// import React, { useState, useEffect } from 'react';
// import { Tabs } from 'antd';
// import Form from './Form';
// import List from './List';

// const { TabPane } = Tabs;

// export default () => {
//   const [activeTab, setActiveTab] = useState('list');

//   const changeTab = (activeKey) => {
//     setActiveTab(activeKey);
//   }

//   return (
//     <>
//       <div className="card-container" style={{ marginTop: 20, marginBottom: 25 }}>
//         <Tabs activeKey={activeTab} onChange={changeTab} type="card">
//           <TabPane tab="List contracts" key="list">
//             <div className="site-layout-content">
//               <List activeKey={activeTab} />
//             </div>
//           </TabPane>
//           <TabPane tab="Create contract" key="2">
//             <div className="site-layout-content">
//               <Form changeTab={changeTab} />
//             </div>
//           </TabPane>
//         </Tabs>
//       </div>
//     </>
//   )
// };
