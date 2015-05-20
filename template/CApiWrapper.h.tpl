#pragma once

#include <ThostFtdcTraderApi.h>
#include <ThostFtdcUserApiStruct.h>
#include <ThostFtdcUserApiDataType.h>
#include <Configure.h>
#include <CTraderHandler.h>
#include <zmq.hpp>
#include <Message.h>
#include <stdio.h>
#include <string.h>
#include <iostream>
#include <assert.h>
#include <map>

class CApiWrapper {

public:
    /// 构造函数
    CApiWrapper(Configure * pConfigure);
    /////////////////  变量定义 //////////////////
    /// 对应的API实例
    CThostFtdcTraderApi * pTraderApi;
    /// 对应的SPI实例
    CTraderHandler * pTraderHandler;
    /// 配置信息
    Configure * pConfigure;
    /// RequestID序列器
    int RequestID;
    /// 上次出错代码
    int lastErrorCode;
    /// 上次出错信息
    std::string lastErrorMessage;
    /// 启动CTP连接
    void init();
    /// 获取下一个RequestID序列
    int getNextRequestID();
    /// 获取当前RequestID序列
    int getCurrentRequestID();
    /// 获取上次出错代码
    int getLastErrorCode();
    /// 获取上次错误信息
    std::string getLastErrorMessage();

    void initApiMap();

    ////////////// API方法的wrapper ///////////////
    {% for method in reqMethodDict.itervalues() %}
    	{{ method['remark'] }}
    	int {{method['name']}}(std::string jsonString);
    {% endfor %}

    std::map<std::string,int (CApiWrapper::*) (std::string)> apiMap;

    int callApiByName(std::string apiName,std::string jsonString);

};
