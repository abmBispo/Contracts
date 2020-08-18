import React from 'react';
import { Table } from 'antd';
import axios from 'axios';
import { BASE_URL } from '../../../main/consts';

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
];

const mapApiToProps = params => {
  return {
    page: params.pagination.current,
    ...params,
  };
};

export default class List extends React.Component {
  state = {
    data: [],
    pagination: {
      current: 1,
      pageSize: 25,
    },
    loading: false,
  };

  componentDidMount() {
    const { pagination } = this.state;
    this.fetch({ pagination });
  }

  handleTableChange = (pagination, filters, sorter) => {
    this.fetch({
      sortField: sorter.field,
      sortOrder: sorter.order,
      pagination
    });
  };

  fetch = (params = {}) => {
    this.setState({ loading: true });
    axios
      .get(`${BASE_URL}/contracts?page=${params.pagination.current}`)
      .then((res) => {
        const { data } = mapApiToProps(res.data);
        this.setState({
          loading: false,
          data: data,
          pagination: {
            ...this.state.pagination,
            ...res.data.pagination
          }
        })
      })
  };

  render() {
    const { data, pagination, loading } = this.state;

    return (
      <Table
        columns={columns}
        rowKey={(record) => record.id}
        dataSource={data}
        pagination={pagination}
        loading={loading}
        onChange={this.handleTableChange}
      />
    );
  }
}
