#include "warningdatamodel.h"
#include "sm_warning.hpp"
#include <QDebug>

#define TABLE_MAX 8

const char* warning_table[TABLE_MAX][2] = {
    "", "",
    "../images/warning/driver_seat_warning.png", "主驾驶座位请系好安全带",
    "../images/warning/copilot_seat_warning.png", "副驾驶座位请系好安全带",
    "../images/warning/engine_failure.png", "发动机故障，请及时维修",
    "../images/warning/airbag_failure.png", "安全气囊故障，请及时维修",
    "../images/warning/obstacle.png", "前方障碍物距离小于30米",
    "../images/warning/obstacle.png", "前方障碍物距离小于80米",
    "../images/warning/obstacle.png", "前方障碍物距离小于180米"
};

WarningDataModel::WarningDataModel(int updateInterval, QObject *parent)
    : DataModel{updateInterval, parent},
    m_index(0)
{
    updateIndex();
}

void WarningDataModel::updateData()
{
    if (warning_Showing_ID.isModified()) {
        unsigned int tmp = m_index; 
        updateIndex();
        emit warning_iconChanged();
        emit warning_messageChanged();
        if ((tmp == 0) || (m_index == 0)) {
            emit warning_visibilityChanged();
        }
    }
}

DATA_PROPERTY_IMPLEMENT(WarningDataModel, warning_visibility, bool)
{
    return m_index != 0;
}

DATA_PROPERTY_IMPLEMENT(WarningDataModel, warning_icon, QString)
{
    return QString(warning_table[m_index][0]);
}

DATA_PROPERTY_IMPLEMENT(WarningDataModel, warning_message, QString)
{
    return QString(warning_table[m_index][1]);
}

void WarningDataModel::updateIndex()
{
    m_index = warning_Showing_ID.getValue();
    if (m_index >= TABLE_MAX) {
        m_index = 0;
    }
}