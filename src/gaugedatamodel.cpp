#include "gaugedatamodel.h"
#include "sm_gauge.hpp"

#define TABLE_MAX 12

const char* gear_table[TABLE_MAX] = {
    "", //Invalid
    "D", //1stgear
    "D", //2stgear
    "D", //3stgear
    "D", //4stgear
    "D", //5stgear
    "D", //6stgear
    "P", //Parking
    "R", //Reverse
    "N", //Neutral
    "D", //Drive
    "S", //Srange
};

GaugeDataModel::GaugeDataModel(int updateInterval, QObject *parent)
    : DataModel{updateInterval, parent},
      m_specialeffects_switch(QProcessEnvironment::systemEnvironment().value("SPECIALEFFECTS_SWITCH"))//获取名为SPECIALEFFECTS_SWITCH的环境变量
{
}

void GaugeDataModel::updateData()
{
    DATA_PROERTY_CHECK(gauge_ESP_VehicleSpeed)
    DATA_PROERTY_CHECK(gauge_EMS_EngineSpeed)
    DATA_PROERTY_CHECK(gauge_TCU_GearForDisplay)
}

DATA_PROPERTY_IMPLEMENT(GaugeDataModel, gauge_ESP_VehicleSpeed, int)
{
    unsigned int res = gauge_ESP_VehicleSpeed.getValue();
    if (res > 180) {
        res = 180;
    }
    return res;
}

DATA_PROPERTY_IMPLEMENT(GaugeDataModel, gauge_EMS_EngineSpeed, double)
{
    unsigned int res = gauge_EMS_EngineSpeed.getValue();
    if (res > 5500) {
        res = 5500;
    }
    return ((double)res) / 1000.0;
}

DATA_PROPERTY_IMPLEMENT(GaugeDataModel, gauge_TCU_GearForDisplay, QString)
{
    unsigned int index = gauge_TCU_GearForDisplay.getValue();
    if (index >= TABLE_MAX) {
        index = 0;
    }
    return QString(gear_table[index]);
}

DATA_PROPERTY_IMPLEMENT(GaugeDataModel, gauge_SpecialEffects_Switch, int)
{
    return (m_specialeffects_switch.toInt());
}
