pragma Singleton
import Quickshell
import QtQuick

Singleton {
    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    readonly property var now: clock.date

    readonly property real synodicDays: {
        const synodicMonth = 29.53059;
        const referenceNewMoon = new Date(Date.UTC(2000, 0, 6, 18, 14));
        const diffMs = now - referenceNewMoon;
        const diffDays = diffMs / (1000 * 60 * 60 * 24);
        return ((diffDays % synodicMonth) + synodicMonth) % synodicMonth;
    }

    readonly property string time: {
        const h = now.getHours().toString().padStart(2, "0");
        const m = now.getMinutes().toString().padStart(2, "0");
        return h + ":" + m;
    }

    readonly property string date: {
        return (now.getMonth() + 1) + "月" + now.getDate().toString().padStart(2, "0") + "日";
    }

    readonly property string weekday: {
        const days = ["周日", "周一", "周二", "周三", "周四", "周五", "周六"];
        return days[now.getDay()];
    }

    readonly property string daytime: {
        const labels = ["Dark Hour", "凌晨", "凌晨", "凌晨", "凌晨", "黎明", "黎明", "上午", "上午", "上午", "上午", "正午", "正午", "正午", "下午", "下午", "下午", "下午", "黄昏", "傍晚", "夜间", "夜间", "深夜", "深夜"];
        return labels[now.getHours()];
    }

    readonly property real moonPhaseDegree: {
        const cycleLength = 29.5;
        const knownNewMoon = new Date('2024-03-10T15:00:00');
        const daysSince = (now - knownNewMoon) / (1000 * 60 * 60 * 24);
        const percentage = (daysSince % cycleLength) / cycleLength;
        var degree = 360 - Math.floor(percentage * 360);
        if (degree >= 355 || degree <= 5)
            return 0;
        if (degree >= 175 && degree <= 185)
            return 180;
        return degree;
    }

    readonly property string moonPhaseName: {
        const phases = ["新月", "蛾眉月", "上弦月", "盈凸月", "满月", "亏凸月", "下弦月", "残月"];
        if (moonPhaseDegree >= 337.5)
            return phases[0];
        return phases[Math.floor((moonPhaseDegree + 22.5) / 45)];
    }
}
