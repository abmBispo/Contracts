import React, { useState, useEffect } from 'react';
import { Table, Tooltip, Button } from 'antd';
import axios from 'axios';
import { BASE_URL } from '../../../main/consts';
import { EditOutlined } from '@ant-design/icons'

const mapApiToProps = params => {
  return {
    page: params.pagination.current,
    ...params,
  };
};

export default (props) => {
  const [loading, setLoading] = useState(false);
  const [pagination, setPagination] = useState({ current: 1, pageSize: 25 });
  const [data, setData] = useState([]);

  useEffect(() => fetch(), [props.activeKey]);

  const columns = [
    {
      title: 'Title',
      dataIndex: 'title',
      sorter: (a, b) => a.title.length - b.title.length,
      sortDirections: ['descend', 'ascend'],
    },
    {
      title: 'Begin date',
      dataIndex: 'begin',
      sorter: (a, b) => a.begin - b.begin,
      sortDirections: ['descend', 'ascend'],
    },
    {
      title: 'End date',
      dataIndex: 'end',
      sortDirections: ['descend', 'ascend'],
      sorter: (a, b) => a.end - b.end,
    },
    {
      title: 'Actions',
      render: (text, record) => (
        <Tooltip title={`Edit contract ${record.title}`}>
          <Button onClick={() => props.showContract(record.id)} type='primary'>
            <EditOutlined style={{ fontSize: 20 }} />
          </Button>
        </Tooltip>
      )
    },
  ];

  const fetch = (params = {}) => {
    setLoading(true);
    axios
      .get(`${BASE_URL}/contracts?page=${pagination.current}`)
      .then((res) => {
        const { data } = mapApiToProps(res.data);
        setLoading(false);
        setData(data);
        setPagination({
          ...pagination,
          ...res.data.pagination
        });
      });
  }

  const handleTableChange = (pagination, filters, sorter) => {
    fetch({
      sortField: sorter.field,
      sortOrder: sorter.order,
      pagination
    });
  }

  return (
    <Table
      columns={columns}
      rowKey={(record) => record.id}
      dataSource={data}
      pagination={pagination}
      loading={loading}
      onChange={handleTableChange}
    />
  );
}
