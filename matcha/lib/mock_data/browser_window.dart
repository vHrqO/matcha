import 'package:matcha/mock_data/session.dart';
import 'package:matcha/model/browser_window.dart';

// Mock data for skeletons
final mockWindow = BrowserWindow(id: 0, tabsItemList: mockSession.tabsItemList);

// Mock data for testing
final mockWindowList = [mockWindow1, mockWindow2];

final mockWindow1 = BrowserWindow(id: 1, tabsItemList: mockSession1.tabsItemList);

final mockWindow2 = BrowserWindow(id: 2, tabsItemList: mockSession2.tabsItemList);
