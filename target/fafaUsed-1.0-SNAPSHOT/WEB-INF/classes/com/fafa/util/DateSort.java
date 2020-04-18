package com.fafa.util;

import com.fafa.pojo.Dialogue;

import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

/**
 * @author 炜哥哥
 * @date 2020/2/25 20:05
 * 按时间给对话对象  进行排序  类
 *
 */
public class DateSort {

    public static void ListSort(List<Dialogue> list) {
        Collections.sort(list, new Comparator<Dialogue>() {
            @Override
            public int compare(Dialogue o1, Dialogue o2) {
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                try {
                    Date dt1 = format.parse(o1.getBuildTime());
                    Date dt2 = format.parse(o2.getBuildTime());
                    if (dt1.getTime() > dt2.getTime()) {
                        return 1;
                    } else if (dt1.getTime() < dt2.getTime()) {
                        return -1;
                    } else {
                        return 0;
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return 0;
            }
        });
    }

}
