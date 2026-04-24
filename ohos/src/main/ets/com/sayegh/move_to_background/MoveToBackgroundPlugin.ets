import common from '@ohos.app.ability.common';
import { BusinessError } from '@kit.BasicServicesKit';
import {
  FlutterPlugin,
  FlutterPluginBinding,
  MethodCall,
  MethodCallHandler,
  MethodChannel,
  MethodResult,
} from '@ohos/flutter_ohos';
import AbilityAware from '@ohos/flutter_ohos/src/main/ets/embedding/engine/plugins/ability/AbilityAware';
import type { AbilityPluginBinding } from '@ohos/flutter_ohos/src/main/ets/embedding/engine/plugins/ability/AbilityPluginBinding';

/** MoveToBackgroundPlugin **/
export default class MoveToBackgroundPlugin implements FlutterPlugin, MethodCallHandler, AbilityAware {
  private channel: MethodChannel | null = null;
  private abilityContext: common.UIAbilityContext | null = null;

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
    this.abilityContext = null;
  }

  onAttachedToAbility(binding: AbilityPluginBinding): void {
    this.abilityContext = binding.getAbility().context as common.UIAbilityContext;
  }

  onDetachedFromAbility(): void {
    this.abilityContext = null;
  }

  onMethodCall(call: MethodCall, result: MethodResult): void {
    if (call.method === 'moveTaskToBack') {
      this.moveTaskToBack(result);
      return;
    }

    result.notImplemented();
  }

  private moveTaskToBack(result: MethodResult): void {
    const abilityContext = this.abilityContext;
    if (abilityContext === null) {
      result.error('no_ability', 'UIAbility context is not attached.', null);
      return;
    }

    // HarmonyOS public APIs do not expose an explicit app-minimize call.
    // terminateSelf keeps the recent mission snapshot by default, which is the closest public behavior.
    try {
      abilityContext.terminateSelf().catch((err: BusinessError) => {
        console.error(
          `MoveToBackgroundPlugin terminateSelf failed, code is ${err.code}, message is ${err.message}`,
        );
      });
      result.success(true);
    } catch (err) {
      const businessError = err as BusinessError;
      result.error('terminate_failed', `${businessError.code}: ${businessError.message}`, null);
    }
  }
}