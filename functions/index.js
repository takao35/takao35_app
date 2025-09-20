/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
// functions/index.js（Node 20）
const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

function assertAdmin(context) {
  if (!context.auth || context.auth.token.role !== 'admin') {
    throw new functions.https.HttpsError('permission-denied', 'Admin only');
  }
}

exports.setUserRole = functions.https.onCall(async (data, context) => {
  assertAdmin(context);
  const { uid, role, banned } = data;
  const valid = ['admin','editor','user'];
  if (!valid.includes(role)) {
    throw new functions.https.HttpsError('invalid-argument', 'invalid role');
  }
  await admin.auth().setCustomUserClaims(uid, { role, banned: !!banned });
  await admin.firestore().collection('users').doc(uid).set(
    { role, banned: !!banned, updatedAt: admin.firestore.FieldValue.serverTimestamp() },
    { merge: true }
  );
  return { ok: true };
});