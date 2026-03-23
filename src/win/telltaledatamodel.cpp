#include "telltaledatamodel.h"
#include <QDebug>

#define DATA_PROPERTY_EASY_IMPLEMENT(func, name, type) \
type func::get##name() const \
{ \
    return m_switch; \
}

TelltaleDataModel::TelltaleDataModel(int updateInterval, QObject *parent)
    : DataModel{updateInterval, parent},
      m_FunctionLamp_timer(nullptr),
      m_FunctionLamp_value(false),
      m_index(0),
      m_switch(false)
{
}

void TelltaleDataModel::updateData()
{
    if (m_index < 21) {
        m_switch = true;
    } else {
        m_switch = false;
        m_FunctionLamp_value = false;
    }

    switch(m_index) {
        case 0:
            emit telltale_EMS_SVSChanged();
            break;
        case 1:
            emit telltale_SRS_BuckleSwitchStatusChanged();
            break;
        case 2:
            emit telltale_BCM_FrontFoglampStatusChanged();
            break;
        case 3:
            emit telltale_BCM_RearFoglampStatusChanged();
            break;
        case 4:
            emit telltale_BCM_HighBeamStatusChanged();
            break;
        case 5:
            emit telltale_BCM_LowBeamStatusChanged();
            break;
        case 6:
            emit telltale_BCM_PositionLampStatusChanged();
            break;
        case 7:
            emit telltale_EMS_MILChanged();
            break;
        case 8:
            emit telltale_EMS_CoolanTemperatureErrorChanged();
            break;
        case 9:
            emit telltale_EMS_OilPressureStsChanged();
            break;
        case 10:
            emit telltale_ESP_ABSFailStatusChanged();
            break;
        case 11:
            emit telltale_SRS_WarningLampStatusChanged();
            break;
        case 12:
            emit telltale_TCU_TransFailureStatusChanged();
            break;
        case 13:
            m_FunctionLamp_value = true;
            emit telltale_EPB_FunctionLampChanged();
            break;
        case 14:
            emit telltale_BCM_BatteryStatusChanged();
            break;
        case 15:
            emit telltale_BCM_DoorStatusChanged();
            break;
        case 16:
            emit telltale_BCM_TurnIndicatorLeftChanged();
            break;
        case 17:
            emit telltale_BCM_TurnIndicatorRightChanged();
            break;
        case 18:
        case 19:
        case 20:
        {
            if (m_FunctionLamp_timer == nullptr) {
                m_FunctionLamp_timer = new QTimer();
                connect(m_FunctionLamp_timer, &QTimer::timeout, this, &TelltaleDataModel::timeout_FunctionLamp);
                m_FunctionLamp_timer->start(250);
            }
            break;
        }
        case 21:
        {
            delete m_FunctionLamp_timer;
            m_FunctionLamp_timer = nullptr;
            emit telltale_EMS_CoolanTemperatureErrorChanged();
            emit telltale_EMS_OilPressureStsChanged();
            emit telltale_EMS_SVSChanged();
            emit telltale_EMS_MILChanged();
            emit telltale_ESP_ABSFailStatusChanged();
            emit telltale_SRS_WarningLampStatusChanged();
            emit telltale_SRS_BuckleSwitchStatusChanged();
            emit telltale_TCU_TransFailureStatusChanged();
            emit telltale_EPB_FunctionLampChanged();
            emit telltale_BCM_BatteryStatusChanged();
            emit telltale_BCM_DoorStatusChanged();
            emit telltale_BCM_HighBeamStatusChanged();
            emit telltale_BCM_LowBeamStatusChanged();
            emit telltale_BCM_TurnIndicatorRightChanged();
            emit telltale_BCM_TurnIndicatorLeftChanged();
            emit telltale_BCM_RearFoglampStatusChanged();
            emit telltale_BCM_FrontFoglampStatusChanged();
            emit telltale_BCM_PositionLampStatusChanged();
            break;
        }
        default:
            break;
    }

    m_index++;
    if (m_index > 21) {
        m_index = 0;
    }
}

DATA_PROPERTY_EASY_IMPLEMENT(TelltaleDataModel, telltale_EMS_CoolanTemperatureError, bool)
DATA_PROPERTY_EASY_IMPLEMENT(TelltaleDataModel, telltale_EMS_OilPressureSts, bool)
DATA_PROPERTY_EASY_IMPLEMENT(TelltaleDataModel, telltale_EMS_SVS, bool)
DATA_PROPERTY_EASY_IMPLEMENT(TelltaleDataModel, telltale_EMS_MIL, bool)
DATA_PROPERTY_EASY_IMPLEMENT(TelltaleDataModel, telltale_ESP_ABSFailStatus, bool)
DATA_PROPERTY_EASY_IMPLEMENT(TelltaleDataModel, telltale_SRS_WarningLampStatus, bool)
DATA_PROPERTY_EASY_IMPLEMENT(TelltaleDataModel, telltale_SRS_BuckleSwitchStatus, bool)
DATA_PROPERTY_EASY_IMPLEMENT(TelltaleDataModel, telltale_TCU_TransFailureStatus, bool)
DATA_PROPERTY_EASY_IMPLEMENT(TelltaleDataModel, telltale_BCM_BatteryStatus, bool)
DATA_PROPERTY_EASY_IMPLEMENT(TelltaleDataModel, telltale_BCM_DoorStatus, bool)
DATA_PROPERTY_EASY_IMPLEMENT(TelltaleDataModel, telltale_BCM_HighBeamStatus, bool)
DATA_PROPERTY_EASY_IMPLEMENT(TelltaleDataModel, telltale_BCM_LowBeamStatus, bool)
DATA_PROPERTY_EASY_IMPLEMENT(TelltaleDataModel, telltale_BCM_TurnIndicatorRight, bool)
DATA_PROPERTY_EASY_IMPLEMENT(TelltaleDataModel, telltale_BCM_TurnIndicatorLeft, bool)
DATA_PROPERTY_EASY_IMPLEMENT(TelltaleDataModel, telltale_BCM_RearFoglampStatus, bool)
DATA_PROPERTY_EASY_IMPLEMENT(TelltaleDataModel, telltale_BCM_FrontFoglampStatus, bool)
DATA_PROPERTY_EASY_IMPLEMENT(TelltaleDataModel, telltale_BCM_PositionLampStatus, bool)

DATA_PROPERTY_IMPLEMENT(TelltaleDataModel, telltale_EPB_FunctionLamp, bool)
{
    return m_FunctionLamp_value;
}

void TelltaleDataModel::timeout_FunctionLamp()
{
    m_FunctionLamp_value = !m_FunctionLamp_value;
    emit telltale_EPB_FunctionLampChanged();
}
