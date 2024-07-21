if (!window.componentsLoaded) {
    window.componentsLoaded = true;

    function fetchNui(event, data, scriptName) {
        const options = {
            method: 'POST',
            body: JSON.stringify(data ?? {})
        };

        return new Promise((resolve, reject) => {
            fetch(`https://${scriptName ?? window.resourceName}/${event}`, options)
                .then((res) => res.json())
                .then(resolve)
                .catch((err) => {
                    console.log(err);
                    return;
                });
        });
    }

    function SetPopUp(data) {
        if (!data?.buttons) return;

        for (let i = 0; i < data.buttons.length; i++) {
            if (data.buttons[i].cb) data.buttons[i].callbackId = i;
        }

        fetchNui('SetPopUp', data, 'lb-phone').then((buttonId) => {
            if (!data.buttons[buttonId]?.cb) return;
            data.buttons[buttonId].cb();
        });
    }
    window.setPopUp = SetPopUp;

    function SetContextMenu(data) {
        if (!data?.buttons) return;

        for (let i = 0; i < data.buttons.length; i++) {
            if (data.buttons[i].cb) data.buttons[i].callbackId = i;
        }

        fetchNui('SetContextMenu', data, 'lb-phone').then((buttonId) => {
            if (!data.buttons[buttonId]?.cb) return;
            data.buttons[buttonId].cb();
        });
    }
    window.setContextMenu = SetContextMenu;

    function SetContactModal(number) {
        if (!number) return;

        fetchNui('SetContactModal', number, 'lb-phone');
    }
    window.setContactModal = SetContactModal;

    function UseComponent(cb, data) {
        if (!cb || !data?.component) return;

        fetchNui('ShowComponent', data, 'lb-phone')
            .then((data) => {
                cb(data);
            })
            .catch((err) => {
                console.log(err);
                cb(null);
            });
    }
    window.useComponent = UseComponent;

    function SelectGallery(data) {
        UseComponent(data.cb, { ...data, component: 'gallery' });
    }
    window.selectGallery = SelectGallery;

    function SelectGIF(cb) {
        UseComponent(cb, { component: 'gif' });
    }
    window.selectGIF = SelectGIF;

    function SelectEmoji(cb) {
        UseComponent(cb, { component: 'emoji' });
    }
    window.selectEmoji = SelectEmoji;

    function useCamera(cb, data) {
        UseComponent(cb, { ...data, component: 'camera' });
    }

    function colorPicker(cb, data) {
        UseComponent(cb, { ...data, component: 'colorpicker' });
    }

    function contactSelector(cb, data) {
        UseComponent(cb, { ...data, component: 'contactselector' });
    }

    function GetSettings() {
        return new Promise((resolve, reject) => {
            fetchNui('GetSettings', {}, 'lb-phone').then(resolve).catch(reject);
        });
    }
    window.getSettings = GetSettings;

    function GetLocale(path, format) {
        return new Promise((resolve, reject) => {
            fetchNui('GetLocale', { path, format }, 'lb-phone').then(resolve).catch(reject);
        });
    }
    window.getLocale = GetLocale;

    function SendNotification(data) {
        data.app = window.appName;
        if (!data?.title && !data?.content) return console.log('Invalid notification data');
        fetchNui('SendNotification', data, 'lb-phone');
    }
    window.sendNotification = SendNotification;

    let settingListeners = [];
    function OnSettingsChange(cb) {
        if (!cb) return;
        settingListeners.push(cb);
    }
    window.onSettingsChange = OnSettingsChange;

    window.addEventListener('message', (event) => {
        if (event.data.type === 'settingsUpdated') {
            settingListeners.forEach((cb) => cb(event.data.settings));
        }
    });

    function toggleInput(toggle) {
        fetchNui('toggleInput', toggle, 'lb-phone');
    }

    function refreshInputs(inputs) {
        inputs.forEach((input) => {
            input.onfocus = () => toggleInput(true);
            input.onblur = () => toggleInput(false);
        });
    }
    refreshInputs(document.querySelectorAll('input, textarea'));

    const observer = new MutationObserver((mutations) => {
        mutations.forEach((mutation) => {
            mutation.addedNodes.forEach((node) => {
                if (node.childNodes.length > 0) refreshInputs(node.querySelectorAll('input, textarea'));
                if (node.tagName === 'INPUT' || node.tagName === 'TEXTAREA') refreshInputs([node]);
            });
        });
    });
    observer.observe(document.body, { childList: true, subtree: true });

    window.postMessage('componentsLoaded', '*');
}
