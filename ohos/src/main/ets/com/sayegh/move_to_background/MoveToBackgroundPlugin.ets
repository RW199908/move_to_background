import common from '@ohos.app.ability.common';
import { BusinessError } from '@kit.BasicServicesKit';
import UIAbility from '@ohos.app.ability.UIAbility';
import window from '@ohos.window';
import {
  FlutterPlugin,
  FlutterPluginBinding,
  MethodCall,
  MethodCallHandler,
  MethodChannel,
  MethodResult,
} from '@ohos/flutter_ohos';
import FlutterManager from '@ohos/flutter_ohos/src/main/ets/embedding/ohos/FlutterManager';
import AbilityAware from '@ohos/flutter_ohos/src/main/ets/embedding/engine/plugins/ability/AbilityAware';
import type { AbilityPluginBinding } from '@ohos/flutter_ohos/src/main/ets/embedding/engine/plugins/ability/AbilityPluginBinding';

/** MoveToBackgroundPlugin **/
export default class MoveToBackgroundPlugin implements FlutterPlugin, MethodCallHandler, AbilityAware {
  private channel: MethodChannel | null = null;
  private ability: UIAbility | null = null;

  constructor() {
  }

  getUniqueClassName(): string {
    return 'MoveToBackgroundPlugin';
  }

  onAttachedToEngine(binding: FlutterPluginBinding): void {
    this.channel = new MethodChannel(binding.getBinaryMessenger(), 'move_to_background');
    this.channel.setMethodCallHandler(this);
  }

  onDetachedFromEngine(_binding: FlutterPluginBinding): void {
    if (this.channel != null) {
      this.channel.setMethodCallHandler(null);
    }
    this.channel = null;
    this.ability = null;
  }

  onAttachedToAbility(binding: AbilityPluginBinding): void {
    this.ability = binding.getAbility();
  }

  onDetachedFromAbility(): void {
    this.ability = null;
  }

  onMethodCall(call: MethodCall, result: MethodResult): void {
    if (call.method === 'moveTaskToBack') {
      this.moveTaskToBack(result);
      return;
    }

    result.notImplemented();
  }

  private moveTaskToBack(result: MethodResult): void {
    const ability = this.ability;
    if (ability === null) {
      result.error('no_ability', 'UIAbility is not attached.', null);
      return;
    }

    try {
      const windowStage = FlutterManager.getInstance().getWindowStage(ability);
      const mainWindow = windowStage.getMainWindowSync();

      mainWindow.minimize((err: BusinessError) => {
        if (err.code !== 0) {
          result.error('window_error', `${err.code}: ${err.message}`, null);
          return;
        }

        result.success(true);
      });
    } catch (err) {
      const businessError = err as BusinessError;
      result.error('window_error', `${businessError.code}: ${businessError.message}`, null);
    }
  }
}