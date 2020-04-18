package com.fafa.pojo;

import java.util.List;

/**
 * @author 炜哥哥
 * @date 2020/2/25 15:45
 *
 * 买家和卖家的对话扩展类
 */
public class Dialogue {
    private String buildTime;
    private String context;
    private String userName;

    @Override
    public String toString() {
        return "Dialogue{" +
                "buildTime='" + buildTime + '\'' +
                ", context='" + context + '\'' +
                ", userName='" + userName + '\'' +
                '}';
    }

    public String getBuildTime() {
        return buildTime;
    }

    public void setBuildTime(String buildTime) {
        this.buildTime = buildTime;
    }

    public String getContext() {
        return context;
    }

    public void setContext(String context) {
        this.context = context;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
}
