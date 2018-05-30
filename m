Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:51170 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753556AbeE3S36 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 May 2018 14:29:58 -0400
Received: by mail-it0-f66.google.com with SMTP id p3-v6so24387759itc.0
        for <linux-integrity@vger.kernel.org>; Wed, 30 May 2018 11:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <1526508736.3306.6.camel@linux.vnet.ibm.com> <20180517220938.102953-1-mjg59@google.com>
 <1526659412.3404.32.camel@linux.vnet.ibm.com> <CACdnJuvd8Y9N1Bds474BXiikc5R8c41gaHGpJEUO2z_vkXG-XQ@mail.gmail.com>
 <15252CF8C1B4384C8CE16D7D55C66479011414E7BF@BC-MAIL-M04.internal.baidu.com>
In-Reply-To: <15252CF8C1B4384C8CE16D7D55C66479011414E7BF@BC-MAIL-M04.internal.baidu.com>
From: Matthew Garrett <mjg59@google.com>
Date: Wed, 30 May 2018 11:29:45 -0700
Message-ID: <CACdnJus+5Xog03Z1VYdw_8dx64Wg2zzh1b2bL-FDt0O9+p_eGQ@mail.gmail.com>
Subject: Re: [PATCH V4] evm: Allow non-SHA1 digital signatures
To: wangjunwen@baidu.com
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, May 29, 2018 at 11:25 PM Wang,Junwen <wangjunwen@baidu.com> wrote:
> if we need fix this problem
> 1. load the hash algorithm at initial time instead of runtime
> OR
> 2. avoid the crypto_alloc_shash try to load modules in init_desc

The outcome here is presumably going to be failure regardless - if
appraisal is required and the hash module is unavailable, failing to load
the module won't result in deadlock but will result in an unusable machine?
I think the only way this can work is to ensure the crypto modules are
available before a policy is enabled, but let me look to see if there's a
way to at least make the failure clean and more debuggable.
