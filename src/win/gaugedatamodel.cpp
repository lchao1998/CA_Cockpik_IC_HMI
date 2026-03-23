#include "gaugedatamodel.h"

#define TABLE_MAX 12

const char* gear_table[TABLE_MAX] = {
    "", //Invalid
    "", //1stgear
    "", //2stgear
    "", //3stgear
    "", //4stgear
    "", //5stgear
    "", //6stgear
    "P", //Parking
    "R", //Reverse
    "N", //Neutral
    "D", //Drive
    "S", //Srange
};

GaugeDataModel::GaugeDataModel(int updateInterval, QObject *parent)
    : DataModel{updateInterval, parent},
      m_testvspeed(0),
      m_testespeed(0),
      m_gear_index(7),
      m_count(0),
      m_specialeffects_switch(QProcessEnvironment::systemEnvironment().value("SPECIALEFFECTS_SWITCH"))//获取名为SPECIALEFFECTS_SWITCH的环境变量
{
}

void GaugeDataModel::updateData()
{
    if (m_testvspeed < 180) {
        m_testvspeed += 1;
    } else {
        m_testvspeed = 0;
    }
    if (m_testespeed < 5500) {
        m_testespeed += 30;
    } else {
        m_testespeed = 0;
    }
    if (m_count++ > 80) {
        m_count = 0;
        m_gear_index++;
        if (m_gear_index >= TABLE_MAX) {
            m_gear_index = 7;
        }
    }
/*#if defined (SpecialEffects_Switch)
    m_switch = "1";
#endif*/

    emit gauge_ESP_VehicleSpeedChanged();
    emit gauge_EMS_EngineSpeedChanged();
    emit gauge_TCU_GearForDisplayChanged();
}

DATA_PROPERTY_IMPLEMENT(GaugeDataModel, gauge_ESP_VehicleSpeed, int)
{
    return m_testvspeed;
}

DATA_PROPERTY_IMPLEMENT(GaugeDataModel, gauge_EMS_EngineSpeed, double)
{
    return (double)(m_testespeed) / 1000.0;
}

DATA_PROPERTY_IMPLEMENT(GaugeDataModel, gauge_TCU_GearForDisplay, QString)
{
    return QString(gear_table[m_gear_index]);
}

DATA_PROPERTY_IMPLEMENT(GaugeDataModel, gauge_SpecialEffects_Switch, int)
{
    return (m_specialeffects_switch.toInt());
}
