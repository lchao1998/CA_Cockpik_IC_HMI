#include "statusdatamodel.h"
#include <QDebug>
#ifdef SIMULATION
#include "sm_interaction_status.hpp"
#endif

StatusDataModel::StatusDataModel(int updateInterval, QObject *parent)
    : DataModel{updateInterval, parent},
      m_index(1),
      m_adas_status("default"),
      m_navi_flag(false),
#ifdef SIMULATION
      m_time_count(0),
#endif
      m_adas_count(0)
{
}

void StatusDataModel::updateData()
{
#ifdef SIMULATION
    if (interaction_status_Window_Status.getValue() == 2) {
        qDebug() << "StatusDataModel: status_tripcomputer_menuChanged";
        qDebug() << "StatusDataModel: status_adas_statusChanged";
        m_adas_status = "default";
        m_index = 1;
        m_adas_count = 0;
        m_navi_flag = true;
        m_time_count = 11;
        emit status_tripcomputer_menuChanged();
        emit status_adas_statusChanged();
        emit status_navi_statusChanged();
        return;
    } else {
        m_navi_flag = false;
    }
    m_time_count++;
    if (m_time_count > 10) {
        m_time_count = 0;
    } else {
        return;
    }
#endif

    if (m_adas_status != "default") {
        m_adas_count++;
        switch(m_adas_count) {
            case 1:
                m_adas_status = "forward";
                emit status_adas_statusChanged();
                break;
            case 2:
                m_adas_status = "toright";
                emit status_adas_statusChanged();
                break;
            case 3:
                m_adas_status = "forward";
                emit status_adas_statusChanged();
                break;
            case 4:
                m_adas_status = "toleft";
                emit status_adas_statusChanged();
                break;
            case 5:
                m_adas_status = "forward";
                emit status_adas_statusChanged();
                break;
            default:
                m_adas_status = "default";
                m_adas_count = 0;
                m_index = 1;
                emit status_adas_statusChanged();
                emit status_tripcomputer_menuChanged();
                break;
        }
    } else {
        m_index++;
        if (m_index > 3) {
            m_index = 0;
            m_adas_count = 1;
            m_adas_status = "forward";
            emit status_adas_statusChanged();
        }
        emit status_tripcomputer_menuChanged();
    }
    emit status_navi_statusChanged();
}

DATA_PROPERTY_IMPLEMENT(StatusDataModel, status_tripcomputer_menu, QString)
{
    QString status;
    switch (m_index) {
        case 0: {
            status = "default";
            break;
        }
        case 1: {
            status = "Trip";
            break;
        }
        case 2: {
            status = "Speed";
            break;
        }
        case 3: {
            status = "Time";
            break;
        }
        default:
            break;
    }
    qDebug() << "status_tripcomputer_menu = " << status;
    return m_navi_flag ? "default" : status;
}

DATA_PROPERTY_IMPLEMENT(StatusDataModel, status_adas_status, QString)
{
    qDebug() << "status_adas_status = " << m_adas_status;
    return m_navi_flag ? "default" : m_adas_status;
}

DATA_PROPERTY_IMPLEMENT(StatusDataModel, status_navi_status, bool)
{
    return m_navi_flag;
}
