#include "telltaledatamodel.h"
#include "sm_telltale.hpp"

TelltaleDataModel::TelltaleDataModel(int updateInterval, QObject *parent)
    : DataModel{updateInterval, parent},
    m_FunctionLamp_timer(nullptr),
    m_FunctionLamp_value(false)
{
}

void TelltaleDataModel::updateData()
{
    DATA_PROERTY_CHECK(telltale_EMS_CoolanTemperatureError)
    DATA_PROERTY_CHECK(telltale_EMS_OilPressureSts)
    DATA_PROERTY_CHECK(telltale_EMS_SVS)
    DATA_PROERTY_CHECK(telltale_EMS_MIL)
    DATA_PROERTY_CHECK(telltale_ESP_ABSFailStatus)
    DATA_PROERTY_CHECK(telltale_SRS_WarningLampStatus)
    DATA_PROERTY_CHECK(telltale_SRS_BuckleSwitchStatus)
    DATA_PROERTY_CHECK(telltale_TCU_TransFailureStatus)
    DATA_PROERTY_CHECK(telltale_BCM_BatteryStatus)
    DATA_PROERTY_CHECK(telltale_BCM_DoorStatus)
    DATA_PROERTY_CHECK(telltale_BCM_HighBeamStatus)
    DATA_PROERTY_CHECK(telltale_BCM_LowBeamStatus)
    DATA_PROERTY_CHECK(telltale_BCM_TurnIndicatorRight)
    DATA_PROERTY_CHECK(telltale_BCM_TurnIndicatorLeft)
    DATA_PROERTY_CHECK(telltale_BCM_RearFoglampStatus)
    DATA_PROERTY_CHECK(telltale_BCM_FrontFoglampStatus)
    DATA_PROERTY_CHECK(telltale_BCM_PositionLampStatus)

    if (telltale_EPB_FunctionLamp.isModified()) {
        if (telltale_EPB_FunctionLamp.getValue() == 2 && m_FunctionLamp_timer == nullptr) {
            m_FunctionLamp_timer = new QTimer();
            connect(m_FunctionLamp_timer, &QTimer::timeout, this, &TelltaleDataModel::timeout_FunctionLamp);
            m_FunctionLamp_timer->start(250);
        } else {
            if (m_FunctionLamp_timer != nullptr) {
                delete m_FunctionLamp_timer;
                m_FunctionLamp_timer = nullptr;
                m_FunctionLamp_value = false;
            }
        }
        emit telltale_EPB_FunctionLampChanged();
    }
}

DATA_PROPERTY_SIMPLE_IMPLEMENT(TelltaleDataModel, telltale_EMS_CoolanTemperatureError, bool)
DATA_PROPERTY_SIMPLE_IMPLEMENT(TelltaleDataModel, telltale_EMS_OilPressureSts, bool)
DATA_PROPERTY_SIMPLE_IMPLEMENT(TelltaleDataModel, telltale_EMS_SVS, bool)
DATA_PROPERTY_SIMPLE_IMPLEMENT(TelltaleDataModel, telltale_EMS_MIL, bool)
DATA_PROPERTY_SIMPLE_IMPLEMENT(TelltaleDataModel, telltale_ESP_ABSFailStatus, bool)
DATA_PROPERTY_SIMPLE_IMPLEMENT(TelltaleDataModel, telltale_SRS_WarningLampStatus, bool)
DATA_PROPERTY_SIMPLE_IMPLEMENT(TelltaleDataModel, telltale_SRS_BuckleSwitchStatus, bool)
DATA_PROPERTY_SIMPLE_IMPLEMENT(TelltaleDataModel, telltale_TCU_TransFailureStatus, bool)
DATA_PROPERTY_SIMPLE_IMPLEMENT(TelltaleDataModel, telltale_BCM_BatteryStatus, bool)
DATA_PROPERTY_SIMPLE_IMPLEMENT(TelltaleDataModel, telltale_BCM_DoorStatus, bool)
DATA_PROPERTY_SIMPLE_IMPLEMENT(TelltaleDataModel, telltale_BCM_HighBeamStatus, bool)
DATA_PROPERTY_SIMPLE_IMPLEMENT(TelltaleDataModel, telltale_BCM_LowBeamStatus, bool)
DATA_PROPERTY_SIMPLE_IMPLEMENT(TelltaleDataModel, telltale_BCM_TurnIndicatorRight, bool)
DATA_PROPERTY_SIMPLE_IMPLEMENT(TelltaleDataModel, telltale_BCM_TurnIndicatorLeft, bool)
DATA_PROPERTY_SIMPLE_IMPLEMENT(TelltaleDataModel, telltale_BCM_RearFoglampStatus, bool)
DATA_PROPERTY_SIMPLE_IMPLEMENT(TelltaleDataModel, telltale_BCM_FrontFoglampStatus, bool)
DATA_PROPERTY_SIMPLE_IMPLEMENT(TelltaleDataModel, telltale_BCM_PositionLampStatus, bool)

void TelltaleDataModel::timeout_FunctionLamp()
{
    m_FunctionLamp_value = !m_FunctionLamp_value;
    emit telltale_EPB_FunctionLampChanged();
}

DATA_PROPERTY_IMPLEMENT(TelltaleDataModel, telltale_EPB_FunctionLamp, bool)
{
    bool res = false;
    int value = telltale_EPB_FunctionLamp.getValue();
    if (value == 2) {
        res = m_FunctionLamp_value;
    } else if (value == 1) {
        res = true;
    } 

    return res;
}
